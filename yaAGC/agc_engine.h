/*
  Copyright 2003-2006,2009 Ronald S. Burkey <info@sandroid.org>
  
  This file is part of yaAGC.

  yaAGC is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.

  yaAGC is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with yaAGC; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

  In addition, as a special exception, Ronald S. Burkey gives permission to
  link the code of this program with the Orbiter SDK library (or with 
  modified versions of the Orbiter SDK library that use the same license as 
  the Orbiter SDK library), and distribute linked combinations including 
  the two. You must obey the GNU General Public License in all respects for 
  all of the code used other than the Orbiter SDK library. If you modify 
  this file, you may extend this exception to your version of the file, 
  but you are not obligated to do so. If you do not wish to do so, delete 
  this exception statement from your version. 
 
  Filename:	agc_engine.h
  Purpose:	Header file for AGC emulator engine.
  Contact:	Ron Burkey <info@sandroid.org>
  Reference:	http://www.ibiblio.org/apollo
  Mods:		04/05/03 RSB.	Began.
		10/20/03 RSB.	Corrected inclusion of sys/types.h to
				stdint.h instead. 
		11/26/03 RSB.	Up to now, a pseudo-linear space was used to
				model internal AGC memory.  This was simply too
				tricky to work with, because it was too hard to
				understand the address conversions that were
				taking place.  I now use a banked model much
				closer to the true AGC memory map.
		05/06/04 RSB	Added rfopen.
		05/10/04 RSB	Editing channel space in --debug mode now
				actually outputs the data on the virtual wires.
		05/12/04 RSB	Added the backtrace buffer.
		05/13/04 RSB	Increased number of fixed banks from 36 to 40,
				even though the AGC actually had only 36, to
				account for the fact that the AGC's superbank
				calculation goes up to 40.
		05/14/04 RSB	Added interrupt-related stuff.
		05/17/04 RSB	Added constant names for all counter registers
				(RegTIME1, RegTIME2, and so on.)  Added
				ChanSCALER1 and ChanSCALER2.
		05/31/04 RSB	Number of socket/client info now made public
				and hooked for reassignment at runtime.
		06/04/04 RSB	Added ServerStuff.
		06/11/04 RSB	Added int8_t for Win32.
		06/30/04 RSB	Added prototypes for SignExtend, AddSP16, and
				OverflowCorrected.
		07/12/04 RSB	Q is now 16 bits.
		07/15/04 RSB	Data alignment changed to bit 0 instead of 1.
				Introduced REG16.
		07/19/04 RSB	Added SocketInterlaceReload.  Max clients 
				increased from 5 to 10.
		08/12/04 RSB	Added OutputChannel10[], for capturing
				writes to the relay rows of channel 10.
		08/18/04 RSB	Note that the Win32 and embedded definitions
				of int16_t et al. are not portable.
		08/24/04 RSB	Added provisions for SDCC.
		02/27/05 RSB	Added the license exception, as required by
				the GPL, for linking to Orbiter SDK libraries.
		05/15/05 RSB	Location of Portnum variable adjusted to avoid
				link problems on some platforms.
		05/31/05 RSB	Added DebugDeda.
		06/02/05 RSB	Added ChannelRoutineGeneric.
		06/04/05 RSB	Added ChannelOutputAGS.
		06/28/05 RSB	Added digital downlink stuff.
		07/05/05 RSB	Added AllOrErasable.
		08/13/05 RSB	Added the extern "C" stuff, on the advice of
				Mark Grant; similarly, added the 
				agc_clientdata field to agc_t.
		08/22/05 RSB	"unsigned long long" replaced by uint64_t.
		02/26/06 RSB	Miscellaneous changes requested by Mark Grant
				to make the Orbiter integration easier.
				Shouldn't affect non-Orbiter builds.
		03/19/09 RSB	Added DedaQuiet.
		03/30/09 RSB	Moved Downlink from CpuWriteIO() local variable
				to agc_t.
		04/07/09 RSB	Added ProcessDownlinkList and ProcessDownlinkList_t.
   
  For more insight, I'd highly recommend looking at the documents
  http://hrst.mit.edu/hrs/apollo/public/archive/1689.pdf and
  http://hrst.mit.edu/hrs/apollo/public/archive/1704.pdf.
  
*/

#ifndef AGC_SOCKET_ENABLED

#ifdef __cplusplus
extern "C" {
#endif

#ifndef AGC_ENGINE_H
#define AGC_ENGINE_H

#ifndef NULL
#define NULL ((void *) 0)
#endif

// The following is used to get the int16_t datatype.
#ifdef WIN32
// Win32
typedef short int16_t;
typedef signed char int8_t;
#ifdef __MINGW32__
typedef unsigned long long uint64_t;
#else
typedef unsigned __int64 uint64_t;
#endif
#elif defined (__embedded__)
// Embedded, gcc cross-compiler.
typedef short int16_t;
typedef signed char int8_t;
typedef unsigned short uint16_t;
#elif defined (SDCC)
// SDCC (8-bit 8051)
typedef int int16_t;
typedef signed char int8_t;
typedef unsigned uint16_t;
extern long random (void);
#else // WIN32
// All other (Linux, Mac OS, etc.)
//#include <sys/types.h>
#include <stdint.h>
#endif // WIN32

// For socket connections.
#ifdef WIN32
#define SOCKET_BROKEN 1
#else
#define SOCKET_ERROR -1
#define SOCKET_BROKEN (errno == EPIPE)
#endif

//----------------------------------------------------------------------------
// Constants.

// Max number of symbols in a yaAGC sym-dump.
#define MAX_SYM_DUMP 25

// Max number of files in a file dump
#define MAX_FILE_DUMP 25

// Physical AGC timing was generated from a master 1024 KHz clock, divided by 12.
// This resulted in a machine cycle of just over 11.7 microseconds.  Note that the
// constant is unsigned long long.
#define AGC_PER_SECOND ((1024000 + 6) / 12)

// Number of registers to treat as 16 bits rather than 15 bits.  I started here
// with 020, but I found that rupt 4 will load BB into the accumulator and check
// for overflow, with bad results.
#define REG16 3

// Handy names for the memory locations associated with special-purpose 
// registers, in octal.
#define RegA 00
#define RegL 01
#define RegQ 02
#define RegEB 03
#define RegFB 04
#define RegZ 05
#define RegBB 06
#define RegZERO 07
#define RegARUPT 010
#define RegLRUPT 011
#define RegQRUPT 012
// Addresses 013 and 014 are spares.
#define RegZRUPT 015
#define RegBBRUPT 016
#define RegBRUPT 017
#define RegCYR 020
#define RegSR 021
#define RegCYL 022
#define RegEDOP 023
// Addresses 024-057 are counters.
#define RegCOUNTER 024
#define RegTIME2 024
#define RegTIME1 025
#define RegTIME3 026
#define RegTIME4 027
#define RegTIME5 030
#define RegTIME6 031
#define RegCDUX 032
#define RegCDUY 033
#define RegCDUZ 034
#define RegOPTY 035
#define RegOPTX 036
#define RegPIPAX 037
#define RegPIPAY 040
#define RegPIPAZ 041
// 042-044 are spares in the CM, rotational hand controller in LM.
#define RegRHCP 042
#define RegRHCY 043
#define RegRHCR 044
#define RegINLINK 045
#define RegRNRAD 046
#define RegGYROCTR 047
#define RegCDUXCMD 050
#define RegCDUYCMD 051
#define RegCDUZCMD 052
#define RegOPTYCMD 053
#define RegOPTXCMD 054
// 055-056 are spares.
#define RegOUTLINK 057
#define RegALTM 060
// Addresses 061-03777 are general-purpose RAM.
#define RegRAM 060
// Addresses 04000-0117777 are ROM (core memory).
#define RegCORE 04000
#define RegEND 0120000

// Constants related to "input/output channels".
#define NUM_CHANNELS 512
#define ChanSCALER2 03
#define ChanSCALER1 04
#define ChanS 07

#define NUM_INTERRUPT_TYPES 10

// Max number of 15-bit words in a downlink-telemetry list.
#define MAX_DOWNLINK_LIST 260

// Screen buffer for telemetry downlinks.  The terminal must be at least 
// one bigger in each dimension than the actual amount of text used.
#define DEFAULT_SWIDTH 79
#define DEFAULT_SHEIGHT 42
#define SWIDTH 160
#define SHEIGHT 100

// Identifies the various downlink lists, except for erasable dumps.
#define DL_CM_POWERED_LIST 0
#define DL_LM_ORBITAL_MANEUVERS 1
#define DL_CM_COAST_ALIGN 2
#define DL_LM_COAST_ALIGN 3
#define DL_CM_RENDEZVOUS_PRETHRUST 4
#define DL_LM_RENDEZVOUS_PRETHRUST 5
#define DL_CM_PROGRAM_22 6
#define DL_LM_DESCENT_ASCENT 7
#define DL_LM_LUNAR_SURFACE_ALIGN 8
#define DL_CM_ENTRY_UPDATE 9
#define DL_LM_AGS_INITIALIZATION_UPDATE 10

//---------------------------------------------------------------------------
// Data types.

// Stuff for specifying how to print various fields.

typedef enum {
  FMT_SP, FMT_DP, FMT_OCT, FMT_2OCT, FMT_DEC, FMT_2DEC, FMT_USP
} Format_t;

// Function used for writing out telemetry data.
typedef void Swrite_t (void);
typedef char *Sformat_t (int IndexIntoList, int Scale, Format_t Format);

typedef struct {
  int IndexIntoList;	// if -1, then is a spacer.
  char Name[65];
  int Scale;
  Format_t Format;
  Sformat_t *Formatter;
  int Row;		// If 0,0, then just "next" position.
  int Col;
} FieldSpec_t;

typedef struct {
  char Title[SWIDTH + 1];
  FieldSpec_t FieldSpecs[MAX_DOWNLINK_LIST];
} DownlinkListSpec_t;

// A type of function for processing downlink lists.
typedef void ProcessDownlinkList_t (const DownlinkListSpec_t *Spec);

//--------------------------------------------------------------------------
// Each instance of the AGC CPU simulation has a data structure of type agc_t
// that contains the CPU's internal states, the complete memory space, and any
// other little handy items needed to track execution by the CPU.

typedef struct
{
  // The following variable counts the total number of clock cycles since
  // CPU-startup.  A 64-bit integer is used, because with a 32-bit integer 
  // you'd get only about 14 hours before the counter wraps around.
  uint64_t /* unsigned long long */ CycleCounter;
  // All memory -- registers, RAM, and ROM -- is 16-bit, consisting of 15 bits
  // of data and one of (odd) parity.  The MIT documents consistently
  // use octal, so we do as well.
  //int16_t Memory[RegEND];             // Note use of octal.
  int16_t Erasable[8][0400];	// Banks 0,1,2 are "unswitched erasable".
  // There are actually only 36 (0-043) fixed banks, but the calculation of bank
  // numbers by the AGC can theoretically go 0-39 (0-047).  Therefore, I
  // provide some extra.
  int16_t Fixed[40][02000];	// Banks 2,3 are "fixed-fixed".
  // There are also "input/output channels".  Output channels are acted upon
  // immediately, but input channels are buffered from asynchronous data.
  int16_t InputChannel[NUM_CHANNELS];
  int16_t OutputChannel7;
  int16_t OutputChannel10[16];
  // The indexing value.
  int16_t IndexValue;
  int8_t InterruptRequests[1 + NUM_INTERRUPT_TYPES];	// 0-index not used.
  // CPU internal flags.
  unsigned ExtraCode:1;		// Set by the "Extend" instruction.
  unsigned AllowInterrupt:1;
  //unsigned RegA16:1;		// Bit "16" of register A.
  unsigned InIsr:1;		// Set when in an ISR, reset when in normal code.
  unsigned SubstituteInstruction:1;	// Use BBRUPT register.
  unsigned PendFlag:1;		// Multi-MCT instruction pending.
  unsigned PendDelay:3;		// Countdown to pending instruction.
  unsigned ExtraDelay:3;	// ... and extra, for special cases.
  //unsigned RegQ16:1;		// Bit "16" of register Q.
  unsigned DownruptTimeValid:1;	// Set if the DownruptTime field is valid.
  uint64_t /*unsigned long long */ DownruptTime;	// Time when next DOWNRUPT occurs.
  int Downlink;
  // The following pointer is present for whatever use the Orbiter
  // integration squad wants.  The Virtual AGC code proper doesn't use it
  // in any way.
  void *agc_clientdata;
} agc_t;

// Stuff for --debug-dsky mode.
#define MAX_DEBUG_RULES 256
typedef struct
{
  int KeyCode;
  int Channel;
  int Value;
  char Logic;
} DebugRule_t;
#ifdef AGC_ENGINE_C
int DebugDsky = 0;
int NumDebugRules = 0;
DebugRule_t DebugRules[MAX_DEBUG_RULES];
#else
extern int DebugDsky;
extern int NumDebugRules;
extern DebugRule_t DebugRules[MAX_DEBUG_RULES];
#endif

// Stuff for --debug mode.
#define MAX_BACKTRACE_POINTS 100
#define BACKTRACES_PER_LINE 5
typedef struct {
  uint64_t /* unsigned long long */ CycleCounter;
  int16_t Erasable[8][0400];	// Banks 0,1,2 are "unswitched erasable".
  int16_t InputChannel[NUM_CHANNELS];
  int16_t OutputChannel7;
  int16_t OutputChannel10[16];
  int16_t IndexValue;
  int8_t InterruptRequests[1 + NUM_INTERRUPT_TYPES];
  int8_t DueToInterrupt;	// Indicates interrupt type causing jump (0 if not).
  unsigned ExtraCode:1;		// Set by the "Extend" instruction.
  unsigned AllowInterrupt:1;	// Set when interrupts are enabled.
  //unsigned RegA16:1;		// Bit "16" of register A.
  unsigned InIsr:1;		// Set when in an ISR, reset when in normal code.
  unsigned SubstituteInstruction:1;	// Use BBRUPT register.
  //unsigned RegQ16:1;		// Bit "16" of register Q.
} BacktracePoint_t;

typedef struct
{
  int Socket;
  unsigned char Packet[4];
  int Size;
  int ChannelMasks[256];
  //int DedaBufferCount;
  //int DedaBufferWanted;
  //int DedaBufferReadout;
  //int DedaBufferDefault;
  //int DedaBuffer[9];
} Client_t;

#define DEFAULT_MAX_CLIENTS 10

#ifdef AGC_ENGINE_C
int DebugMode = 0;
int SingleStepCounter = -2;		// -2 when not in --debug mode.
int BacktraceInitialized = 0;		// Becomes -1 on error.
// We have a backtrace circular buffer, in which we place an entry every 
// time an instruction is hit that may branch. The buffer is updated only
// if we're in --debug mode.
BacktracePoint_t *BacktracePoints = NULL;
int BacktraceNextAdd = 0;
int BacktraceCount = 0;
// MAX_CLIENTS is the maximum number of hardware simulations which can be
// attached.  The DSKY is always one, presumably.  The array is a list of 
// the sockets used for the clients.  Thus stuff shown below is the 
// DEFAULT setup.  The max number of clients can be change during runtime
// initialization by setting MAX_CLIENTS to a different number, allocating
// new arrays of clients and sockets corresponding to the new size, and 
// then pointing the Clients and ServerSockets pointers at those arrays.
int MAX_CLIENTS = DEFAULT_MAX_CLIENTS;
static Client_t DefaultClients[DEFAULT_MAX_CLIENTS];
static int DefaultSockets[DEFAULT_MAX_CLIENTS];
Client_t *Clients = DefaultClients;
int *ServerSockets = DefaultSockets;
int NumServers = 0;
int SocketInterlaceReload = 50;
int DebugDeda = 0, DedaQuiet = 0;
int DedaMonitor = 0;
int DedaAddress;
uint64_t /* unsigned long long */ DedaWhen;
int DownlinkListBuffer[MAX_DOWNLINK_LIST];
int DownlinkListCount = 0, DownlinkListExpected = 0, DownlinkListZero = -1;
ProcessDownlinkList_t *ProcessDownlinkList = NULL;
int CmOrLm = 0;	// Default is 0 (LM); other choice is 1 (CM)
char Sbuffer[SHEIGHT][SWIDTH + 1];
int Sheight = DEFAULT_SHEIGHT, Swidth = DEFAULT_SWIDTH;
int LastRhcPitch = 0, LastRhcYaw = 0, LastRhcRoll = 0;
#else //AGC_ENGINE_C
extern int DebugMode;
extern int SingleStepCounter;
extern int BacktraceInitialized;
extern BacktracePoint_t *BacktracePoints;
extern int BacktraceNextAdd;
extern int BacktraceCount;
extern int MAX_CLIENTS;
extern Client_t *Clients;
extern int *ServerSockets;
extern int NumServers;
extern int SocketInterlaceReload;
extern int DebugDeda, DedaQuiet;
extern int DedaMonitor;
extern int DedaAddress;
extern uint64_t /* unsigned long long */ DedaWhen;
extern int DownlinkListBuffer[MAX_DOWNLINK_LIST];
extern int DownlinkListCount, DownlinkListExpected, DownlinkListZero;
extern ProcessDownlinkList_t *ProcessDownlinkList;
extern int CmOrLm;
extern char Sbuffer[SHEIGHT][SWIDTH + 1];
extern int Sheight, Swidth;
extern int LastRhcPitch, LastRhcYaw, LastRhcRoll;
#endif //AGC_ENGINE_C

#ifndef DECODE_DIGITAL_DOWNLINK_C
extern Swrite_t *SwritePtr;
#endif

#ifdef SOCKET_API_C
int Portnum = 19697;
#else
extern int Portnum;
#endif


//---------------------------------------------------------------------------
// Function prototypes.

char *nbfgets (char *Buffer, int Length);
void nbfgets_ready (const char *);
int agc_engine (agc_t * State);
int agc_engine_init (agc_t * State, const char *RomImage,
		     const char *CoreDump, int AllOrErasable);
int agc_load_binfile(agc_t *Stage, const char *RomImage);
int ReadIO (agc_t * State, int Address);
void WriteIO (agc_t * State, int Address, int Value);
void CpuWriteIO (agc_t * State, int Address, int Value);
void MakeCoreDump (agc_t * State, const char *CoreDump);
void UnblockSocket (int SocketNum);
//FILE *rfopen (const char *Filename, const char *mode);
void BacktraceAdd (agc_t *State, int Cause);
int BacktraceRestore (agc_t *State, int n);
void BacktraceDisplay (agc_t *State,int Num);
int16_t OverflowCorrected (int Value);
int SignExtend (int16_t Word);
int AddSP16 (int Addend1, int Addend2);
void UnprogrammedIncrement (agc_t *State, int Counter, int IncType);

void DecodeDigitalDownlink (int Channel, int Value, int CmOrLm);
ProcessDownlinkList_t PrintDownlinkList;
void PrintDP (int *Ptr, int Scale, int row, int col);
void PrintSP (int *Ptr, int Scale, int row, int col);
void PrintUSP (int *Ptr, int Scale, int row, int col);
double GetDP (int *Ptr, int Scale);
double GetSP (int *Ptr, int Scale);
double GetUSP (int *Ptr, int Scale);

// API for yaAGC-to-peripheral communications.
void ChannelOutput (agc_t * State, int Channel, int Value);
int ChannelInput (agc_t * State);
void ChannelRoutine (agc_t *State);
void ChannelRoutineGeneric (void *State, void (*UpdatePeripherals) (void *, Client_t *));
void ShiftToDeda (agc_t *State, int Data);

#endif // AGC_ENGINE_H

#ifdef __cplusplus
}
#endif

#endif // AGC_SOCKET_ENABLED

