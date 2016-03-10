import { combineReducers } from 'redux';
import props from './props';
import user from './user';

const rootReducer = combineReducers({
  props,
  user,
});

export default rootReducer;
