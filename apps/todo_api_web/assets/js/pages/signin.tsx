import * as React from 'react';
import {Component} from 'react';

export interface SignInPageProps {

}

class SignInPage extends Component<SignInPageProps, null> {
  constructor(props: SignInPageProps) {
    super(props)
  }
  render() {
    return (
      <h1>signin page</h1>
    );
  }
}

export { SignInPage };
