import {Action} from 'models/action';

export interface SignInArgs {
  email: string,
  password: string,
  passwordConfirmation: string
};

export interface OnSuccessfulSignInArgs {
  email: string,
  jwt: string
}

export interface AccountStatus {
  loggedIn: boolean,
  email: string|null
};

export const SIGNIN_ACTION  = "ACCOUNT_SIGNIN";
export const SIGNOUT_ACTION = "ACCOUNT_SIGNOUT";
export const SIGNIN_SUCCESS_ACTION = "ACCOUNT_SIGNIN_SUCCESS";

export const createSignInAction = (args: SignInArgs): Action<SignInArgs> => {
  return {
    type: SIGNIN_ACTION,
    args: args
  }
};

//for handling a success from the server
export const createOnSigninSuccess = (args: OnSuccessfulSignInArgs): Action<OnSuccessfulSignInArgs> => {
  return {
    type: SIGNIN_SUCCESS_ACTION,
    args: args
  }
};

export const createSignOutAction = (): Action<null> => {
  return {
    type: SIGNOUT_ACTION,
    args: null
  }
};
