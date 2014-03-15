/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

part of EventableTest;

void runEventEmitterTests(){

  group('EventEmitter', (){

    setUp(setUpTestObjects);

    tearDown(tearDownTestObjects);

    test('EventActions are called asynchronously.', (){
      emitter1.emitEvent(TypeA);
      expect(lastDetectedEvent, equals(null));
      Timer.run(expectAsync0((){
        expect(lastDetectedEvent.emitter, equals(emitter1));
      }));
    });

    test('listening to OMNI event type detects all events from an emitter.', (){
      detector.ignoreAllEvents();
      detector.listen(emitter1, Omni, detectEvent);
      emitter1.emitEvent(TypeA);
      emitter1.emitEvent(TypeA);
      emitter1.emitEvent(TypeB);
      emitter2.emitEvent(TypeB);
      Timer.run(expectAsync0((){
        expect(eventADetectedCount, equals(2));
        expect(eventBDetectedCount, equals(1));
      }));
    });

    test('throws an EmitTimeQueueChangeError if an attempt is made to add or remove an EventAction during the time that event is being emitted.', (){
      var detectorCopy = detector;
      var error;
      emitter1.addEventAction(TypeA, (event){
          detectorCopy.ignoreAllEvents();
      });
      emitter1.emitEvent(TypeA).catchError((e){
        error = e;
      });
      Timer.run(expectAsync0((){
        expect(error is EmitTimeQueueChangeError, equals(true));
      }));
    });

  });

}