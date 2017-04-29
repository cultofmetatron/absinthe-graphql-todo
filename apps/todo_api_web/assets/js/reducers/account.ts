
import * as Immutable from 'immutable';
import {Action} from 'models/action';
import {SignInArgs, AccountStatus, SIGNIN_ACTION} from 'actions/account';


const signIn = (state: Immutable.Map<string, AccountStatus>, action: Action<SignInArgs>): Immutable.Map<string, AccountStatus> => {
  const status: AccountStatus = {
    loggedIn: true,
    email: action.args.email
  }; 
  return state.set("account_status", status);
};

const signOut = (state: Immutable.Map<string, AccountStatus>): Immutable.Map<string, AccountStatus> => {
  return state.set("account_status", {
    loggedIn: false,
    email: null
  });
};

const initialStatus: AccountStatus = {
  loggedIn: false,
  email: null
}; 

export const accountReducer = (state: Immutable.Map<string, AccountStatus>=Immutable.fromJS({account_status: initialStatus}), message: Action<any>) => {
  switch (message.type) {
    case SIGNIN_ACTION :
      return signIn(state, message.args);
    default:
      return state;
  }
}





