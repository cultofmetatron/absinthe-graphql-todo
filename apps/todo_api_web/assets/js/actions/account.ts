

export interface SignInArgs {
  email: string,
  password: string,
  passwordConfirmation: string
}


export interface AccountStatus {
  loggedIn: boolean,
  email: string|null
}

export const SIGNIN_ACTION  = "ACCOUNT_SIGNIN";
export const SIGNOUT_ACTION = "ACCOUNT_SIGNOUT";

