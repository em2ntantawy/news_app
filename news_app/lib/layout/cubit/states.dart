abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class NewsGetBusinessSucessState extends NewsStates {}

class NewsGetBusinessErorrState extends NewsStates {
  final String error;
  NewsGetBusinessErorrState(this.error);
}

class NewsBusinessLoadingState extends NewsStates {}

class NewsGetScienceSucessState extends NewsStates {}

class NewsGetScienceErorrState extends NewsStates {
  final String error;
  NewsGetScienceErorrState(this.error);
}

class NewsScienceLoadingState extends NewsStates {}

class NewsGetSportsSucessState extends NewsStates {}

class NewsGetSportsErorrState extends NewsStates {
  final String error;
  NewsGetSportsErorrState(this.error);
}

class NewsSportsLoadingState extends NewsStates {}

class NewsGetSearchSucessState extends NewsStates {}

class NewsGetSearchErorrState extends NewsStates {
  final String error;
  NewsGetSearchErorrState(this.error);
}

class NewsSearchLoadingState extends NewsStates {}

class AppChangeModeState extends NewsStates {}
