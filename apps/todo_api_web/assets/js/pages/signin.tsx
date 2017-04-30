import * as React from 'react';
import {Component} from 'react';
import { AppLayout } from 'components/layout/app.layout';
import { SignInComponent } from 'components/account/signin.component';

export interface SignInPageProps {

}

class SignInPage extends Component<SignInPageProps, null> {
  constructor(props: SignInPageProps) {
    super(props)
  }
  render() {
    return (
      <AppLayout>
        <SignInComponent />
      </AppLayout>
    );
  }
}

export { SignInPage };
