//
//  JKAudioRecordController.swift
//  Recorder
//
//  Created by JOSEPH KERR on 3/4/16.
//  Copyright © 2016 JOSEPH KERR. All rights reserved.
//

import UIKit
import AVFoundation;

class JWAudioRecorderController {
    
    // MARK: Properties
    
    var micOutputFile: AVAudioFile?
    var micOutputFileURL: NSURL?
    var recording: Bool = false
    var metering: Bool = false

    private var recorded: Bool = false
    private var meterAvgSamples: [Float] = []
    private var meterPeakSamples: [Float] = []
    
    let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!

    // id should be public read only
    private (set) internal var recordingId: String?

    private var audioRecorder: AVAudioRecorder?
    
    // MARK: initialization
    init(){
        
        
    }
    
    convenience init(metering: Bool) {
        self.init()
        self.metering = metering
        initializeController()
    }
    
    
    func initializeController() {
        
        if (metering) {
            // init samples
        }
        recording = false;
        recorded = false;
        
        fileURLs()
        
        let channelLayout = AVAudioChannelLayout(layoutTag: kAudioChannelLayoutTag_Stereo)
        let micFormat = AVAudioFormat(commonFormat: .PCMFormatFloat32, sampleRate: 44100, interleaved: false, channelLayout: channelLayout)
        
        do {
            let audioRecorder = try AVAudioRecorder(URL: micOutputFileURL!, settings: micFormat.settings)
            
            audioRecorder.meteringEnabled = metering
            audioRecorder.prepareToRecord()
            
            self.audioRecorder = audioRecorder
            
        } catch {
            print("Error: \(error)")
        }
        
    }
    
    func currentTime() -> Double {
    
        if let ar = audioRecorder {
            return ar.currentTime
        } else {
            return 0
        }
    
    }
    
    func record() {
        
        if let ar = audioRecorder {
            ar.meteringEnabled = metering
            ar.record()
            recording = true
            if metering {
                //            [self startMeteringTimer];
                
            }
        }
    }
    
    func stopRecording() {

        if let ar = audioRecorder {
            ar.stop()
        }

        recording = false;
        recorded = true;
    }
    
    /*
    -(BOOL)hasRecorded
    {
    return _recorded;
    }
    
    -(void)dealloc {
    
    [self removeUnRecorded];
    
    }
    -(void)removeUnRecorded {
    
    NSLog(@"%s ",__func__);
    NSLog(@"REMOVE recording %@",_recordingId);
    if (_recorded == NO) {
    [_audioRecorder stop];
    if ([_audioRecorder deleteRecording] == NO) {
    NSLog(@"FAILED ");
    }
    }
    }
*/
    



    
    func fileURLs() {
    // .caf = CoreAudioFormat
        let cacheKey = NSUUID().UUIDString
        let filename = "clipRecording_\(cacheKey).caf"
        recordingId = cacheKey

        print("NEW recording \(recordingId)")
    
        micOutputFileURL = DocumentsDirectory.URLByAppendingPathComponent(filename)
        
    }

    
    //    -(NSString*)documentsDirectoryPath {
    //    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    return [searchPaths objectAtIndex:0];
    //    }

    
}



//    AVAudioChannelLayout *layout = [[AVAudioChannelLayout alloc] initWithLayoutTag:kAudioChannelLayoutTag_Stereo];
//    AVAudioFormat* micFormat =
//    [[AVAudioFormat alloc] initWithCommonFormat:AVAudioPCMFormatFloat32 sampleRate:44100. interleaved:NO channelLayout:layout];
//    NSError *error;
//    self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:_micOutputFileURL settings:[micFormat settings] error:&error];
//    _audioRecorder.meteringEnabled = _metering;
//    [_audioRecorder prepareToRecord];

/*
@interface JWAudioRecorderController (){
    AVAudioFile* _micOutputFile;
    BOOL _recorded;
    BOOL _recording;
    BOOL _suspendVAB;
    dispatch_queue_t _bufferReceivedQueue;
}
@property (strong, nonatomic) AVAudioRecorder *audioRecorder;
@property (nonatomic,readwrite) BOOL recording;
@property (nonatomic,strong)  NSTimer *meteringTimer;
@property (nonatomic,strong)  NSMutableArray *meterSamples;
@property (nonatomic,strong)  NSMutableArray *meterPeakSamples;
@property (nonatomic,strong)  NSDate *lastMeterTimeStamp;
@property (nonatomic,strong)  NSMutableDictionary *scrubberTrackIds;
@property (nonatomic,strong) id <JWScrubberBufferControllerDelegate> scrubberBufferController;
@property (nonatomic, readwrite) NSString *recordingId;
@end

@implementation JWAudioRecorderController

-(instancetype)initWithMetering:(BOOL)metering {
    
    if (self = [super init]) {
        _metering = metering;
        [self initializeController];
    }
    return self;
}


@interface JWAudioRecorderController : NSObject <JWEffectsModifyingProtocol>
-(instancetype)initWithMetering:(BOOL)metering;
@property (nonatomic)NSURL* micOutputFileURL;
@property (nonatomic) BOOL metering;
@property (nonatomic, readonly) BOOL hasRecorded;
@property (nonatomic, readonly) BOOL recording;
@property (nonatomic, readonly) NSString *recordingId;

-(NSTimeInterval)currentTime;

-(void)initializeController;
-(void)record;
-(void)stopRecording;
-(void)registerController:(id <JWScrubberBufferControllerDelegate> )myScrubberContoller
withTrackId:(NSString*)trackId
forPlayerRecorder:(NSString*)player;

@end

*/
