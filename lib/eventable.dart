/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

/**
 * Mixins to make any object into an [EventEmitter] or [EventDetector] and create
 * custom [Event] objects.
 */
library Eventable;

import 'dart:async';
import 'dart:mirrors';

part 'emit_time_queue_change_error.dart';
part 'duplicate_event_setting_error.dart';
part 'i_event.dart';
part 'event_emitter.dart';
part 'event_detector.dart';

/**
 * Special type used for listening to all events from an [EventEmitter]
 * with a single [EventAction].
 */
abstract class Omni implements IEvent{}

/// Function signature of an [EventAction].
typedef void EventAction(IEvent event);