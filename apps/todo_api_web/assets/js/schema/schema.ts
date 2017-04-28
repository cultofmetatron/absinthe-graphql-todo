//  This file was automatically generated and should not be edited.
/* tslint:disable */

export interface SigninMutationVariables {
  email: string;
  password: string;
}

export interface SigninMutation {
  // sign the user in
  signin: {
    id: string | null,
    email: string | null,
    jwt: string | null,
  } | null;
}

export interface SignupMutationVariables {
  email: string;
  password: string;
  passwordConfirmation: string;
}

export interface SignupMutation {
  // signup a user
  signup: {
    id: string | null,
    email: string | null,
    jwt: string | null,
  } | null;
}
/* tslint:enable */
