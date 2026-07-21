class AppLabels {
  final String dashboardTitle;
  final String greeting;
  final String takeCare;
  final String kcalBurned;
  final String hydration;
  final String addWater;
  final String startActivity;
  final String chooseActivity;
  final String walking;
  final String running;
  final String cycling;
  final String other;
  final String activityInProgress;
  final String elapsedTime;
  final String pause;
  final String resume;
  final String stop;
  final String intensityTitle;
  final String intensityQuestion;
  final String intensityEasy;
  final String intensityMedium;
  final String intensityHard;
  final String congrats;
  final String greatSession;
  final String hydrationReminder;
  final String activity;
  final String duration;
  final String expense;
  final String continueBtn;
  final String profileTitle;
  final String nameLabel;
  final String ageLabel;
  final String genderLabel;
  final String heightLabel;
  final String weightLabel;
  final String saveBtn;
  final String profileUpdated;
  final String male;
  final String female;
  final String otherGender;
  final String minutes;
  final String seconds;
  final String hours;

  AppLabels({
    required this.dashboardTitle,
    required this.greeting,
    required this.takeCare,
    required this.kcalBurned,
    required this.hydration,
    required this.addWater,
    required this.startActivity,
    required this.chooseActivity,
    required this.walking,
    required this.running,
    required this.cycling,
    required this.other,
    required this.activityInProgress,
    required this.elapsedTime,
    required this.pause,
    required this.resume,
    required this.stop,
    required this.intensityTitle,
    required this.intensityQuestion,
    required this.intensityEasy,
    required this.intensityMedium,
    required this.intensityHard,
    required this.congrats,
    required this.greatSession,
    required this.hydrationReminder,
    required this.activity,
    required this.duration,
    required this.expense,
    required this.continueBtn,
    required this.profileTitle,
    required this.nameLabel,
    required this.ageLabel,
    required this.genderLabel,
    required this.heightLabel,
    required this.weightLabel,
    required this.saveBtn,
    required this.profileUpdated,
    required this.male,
    required this.female,
    required this.otherGender,
    required this.minutes,
    required this.seconds,
    required this.hours,
  });

  static final Map<String, AppLabels> languages = {
    'fr': AppLabels(
      dashboardTitle: 'Tableau de bord',
      greeting: 'Bonjour',
      takeCare: "Prenez soin de vous aujourd'hui.",
      kcalBurned: 'kcal dépensées',
      hydration: 'Hydratation',
      addWater: '+ 200ml 💧',
      startActivity: 'DÉMARRER UNE ACTIVITÉ',
      chooseActivity: 'Choisir une activité',
      walking: 'Marche',
      running: 'Course',
      cycling: 'Vélo',
      other: 'Autre',
      activityInProgress: 'Activité en cours',
      elapsedTime: 'Temps écoulé',
      pause: 'PAUSE',
      resume: 'REPRENDRE',
      stop: 'STOP',
      intensityTitle: "Intensité de l'effort",
      intensityQuestion: 'Comment qualifieriez-vous votre séance ?',
      intensityEasy: 'Tranquille',
      intensityMedium: 'Sportif',
      intensityHard: 'Intense',
      congrats: 'Bravo',
      greatSession: 'Quelle superbe séance ! Vous progressez vers vos objectifs.',
      hydrationReminder: 'N\'oubliez pas de bien vous hydrater pour récupérer ! 💧',
      activity: 'Activité',
      duration: 'Durée',
      expense: 'Dépense',
      continueBtn: 'CONTINUER',
      profileTitle: 'Mon Profil',
      nameLabel: 'Nom',
      ageLabel: 'Âge',
      genderLabel: 'Genre',
      heightLabel: 'Taille (cm)',
      weightLabel: 'Poids (kg)',
      saveBtn: 'ENREGISTRER',
      profileUpdated: 'Profil mis à jour !',
      male: 'Homme',
      female: 'Femme',
      otherGender: 'Autre',
      minutes: 'm',
      seconds: 's',
      hours: 'h',
    ),
    'en': AppLabels(
      dashboardTitle: 'Dashboard',
      greeting: 'Hello',
      takeCare: "Take care of yourself today.",
      kcalBurned: 'kcal burned',
      hydration: 'Hydration',
      addWater: '+ 200ml 💧',
      startActivity: 'START AN ACTIVITY',
      chooseActivity: 'Choose an activity',
      walking: 'Walking',
      running: 'Running',
      cycling: 'Cycling',
      other: 'Other',
      activityInProgress: 'Activity in progress',
      elapsedTime: 'Elapsed time',
      pause: 'PAUSE',
      resume: 'RESUME',
      stop: 'STOP',
      intensityTitle: 'Effort intensity',
      intensityQuestion: 'How would you rate your session?',
      intensityEasy: 'Easy',
      intensityMedium: 'Sporty',
      intensityHard: 'Intense',
      congrats: 'Well done',
      greatSession: 'What a great session! You are progressing toward your goals.',
      hydrationReminder: 'Don\'t forget to stay hydrated to recover! 💧',
      activity: 'Activity',
      duration: 'Duration',
      expense: 'Burned',
      continueBtn: 'CONTINUE',
      profileTitle: 'My Profile',
      nameLabel: 'Name',
      ageLabel: 'Age',
      genderLabel: 'Gender',
      heightLabel: 'Height (cm)',
      weightLabel: 'Weight (kg)',
      saveBtn: 'SAVE',
      profileUpdated: 'Profile updated!',
      male: 'Male',
      female: 'Female',
      otherGender: 'Other',
      minutes: 'm',
      seconds: 's',
      hours: 'h',
    ),
  };
}
