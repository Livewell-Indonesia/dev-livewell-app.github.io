class InternalServices {
  static final InternalServices _instance = InternalServices._internal();
  //late AuthServiceInterface auth;
  // late MeServiceInterface me;
  // late PinServiceInterface pin;
  // late ActivityServiceInterface activity;
  // late BankServiceInterface bank;
  // late WithdrawServiceInterface withdraw;

  factory InternalServices() => _instance;

  InternalServices._internal();

  InternalServices.init(
      //required AuthServiceInterface authService,
      // required MeServiceInterface meService,
      // required PinServiceInterface pinService,
      // required ActivityServiceInterface activityService,
      // required BankServiceInterface bankService,
      // required WithdrawServiceInterface withdrawService,
      ) {
    //instance.auth = authService;
    // _instance.me = meService;
    // _instance.pin = pinService;
    // _instance.activity = activityService;
    // _instance.bank = bankService;
    // _instance.withdraw = withdrawService;
  }
}
