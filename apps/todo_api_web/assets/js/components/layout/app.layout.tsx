import * as React from 'react';
import { Component, ComponentClass, Props} from 'react';

export interface LayoutProps {
  //children: any[]
}

class AppLayout extends Component<LayoutProps, undefined> {
  constructor(props: LayoutProps) {
    super(props);
  }
  render() {
    return (
      <div>
        <h1> layout </h1>
        <div>
          { this.props.children }
        </div>
      </div>
    );
  }
}


export {AppLayout}


