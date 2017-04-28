
import {combineReducers} from 'redux';

import {accountReducer as account} from 'reducers/account';

const appReducer = combineReducers({
  account
});
