
import * as React from 'react';
import { render } from 'react-dom';
import { Provider } from 'react-redux';
import createHistory from 'history/createBrowserHistory';
import { createStore, combineReducers, applyMiddleware } from 'redux';
import { ConnectedRouter, routerReducer, routerMiddleware, push } from 'react-router-redux'
import { Route } from 'react-router'
import * as reducers from 'reducers/index';

import  { Action } from 'models/action';

import {Tester} from 'components/tester'
import { SignInPage } from 'pages/signin';
/*
  Boots up the application

*/
export const bootLoad = () => {
  //boot up history
  const history = createHistory();
  const reducer = combineReducers({
    ...reducers,
    router: routerReducer
  });
  const middleware = routerMiddleware(history);

  const store = createStore(reducer, applyMiddleware(middleware));
  //debugger
  return (
    <Provider store={store}>
      { /* ConnectedRouter will use the store from Provider automatically */ }
      <ConnectedRouter history={history}>
        <div>
          <Route exact path="/" component={Tester}/>
          <Route exact path="/signin" component={SignInPage} />
        </div>
      </ConnectedRouter>
    </Provider>
  );

};

