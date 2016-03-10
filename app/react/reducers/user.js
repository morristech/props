import {
  RECEIVE_USER,
} from '../constants/action-types';

function user(state = {}, action) {
  switch (action.type) {
  case RECEIVE_USER:
    return Object.assign({}, state, action.user);
  default:
    return state;
  }
}

export default user;
