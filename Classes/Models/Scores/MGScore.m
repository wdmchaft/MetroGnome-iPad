//
//  MGScore.m
//  MetroGnomeiPad
//
//  Created by Alexander Pease on 12/20/11.
//  Copyright (c) 2011 Princeton University. All rights reserved.
//

#import "MGScore.h"

@implementation MGScore
@synthesize fileName        = _fileName;
@synthesize partsArray      = _partsArray;
@synthesize timeSignature   = _timeSignature;
@synthesize trackMode       = _trackMode;
@synthesize quarterNote     = _quarterNote;
@synthesize totalPulses     = _totalPulses;

#pragma mark 
#pragma mark Initialization
-(void)dealloc {
    [super dealloc];   
}

//The number of notes/chords.
-(id)initWithCapacity:(NSInteger)capacity 
     andTimeSignature:(MGTimeSignature *)timeSignature {
    if (self = [super init]) {
        if (capacity == 0) {
            capacity = 1;
        }
        
        if (timeSignature == nil) {
            self.timeSignature = [MGTimeSignature commonTime];
        }
        else {
            self.timeSignature = timeSignature;
        }
    }
    return self;
}

-(id)initWithCapacity:(NSInteger)capacity {
    return [self initWithCapacity:capacity andTimeSignature:nil];
}

-(id)initWithTimeSignature:(MGTimeSignature *)timeSignature {
    return [self initWithCapacity:0 andTimeSignature:timeSignature];
}

-(id)initWithMidiFile: (MidiFile *)midiFile {
    if (self = [super init]) {
        self.fileName = [midiFile filename];
        self.timeSignature = [midiFile timesig];
        self.totalPulses = [midiFile totalpulses];
        self.quarterNote = [midiFile quarternote];
        self.trackMode = [midiFile trackmode];
        
        for (int i = 0; i < [[midiFile events] count]; i++) {
            Array *trackArray = [[midiFile events] get:i];
            MGPart *part = [[MGPart alloc]initWithMidiEventArray:trackArray];
            [self.partsArray insertObject:part atIndex:i];
        }  
    }
    return self;
}

//Check to make sure this doesn't double init
-(id)initWithFileName: (NSString *)fileName {
        MidiFile *midiFile = [[MidiFile alloc]initWithFile:fileName];
        return [self initWithMidiFile:midiFile];
}

#pragma mark
#pragma mark Methods

-(void)add:(MGPart *)part {
    [self.partsArray addObject:part];
}



@end
