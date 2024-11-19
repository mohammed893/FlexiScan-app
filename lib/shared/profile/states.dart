// shared/profile/states.dart
abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ProfileIncompleteState extends ProfileStates {}

class ProfileCompleteState extends ProfileStates {}

class ProfileUpdatedState extends ProfileStates {}
class ProfileLoadingState extends ProfileStates {}
