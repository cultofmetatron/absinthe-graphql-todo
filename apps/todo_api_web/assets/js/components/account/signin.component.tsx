import * as React from 'react';
import {Component} from 'react';
import { Button } from 'react-toolbox/lib/button';


export interface signInProps {

}

class SignInComponent extends Component<signInProps, undefined> {
  render() {
    return (
      <div>
        <h1>signin component</h1>
        <Button icon="add" label='Add this' raised disabled />
        <Button label='Bookmark' raised primary />
      </div>
    );
  }
}

export {SignInComponent}
