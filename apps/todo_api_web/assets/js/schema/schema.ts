//  This file was automatically generated and should not be edited.
/* tslint:disable */

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
