import assign from 'lodash/assign';

import {
  RECEIVE_USERS,
} from '../constants/action-types';

function users(state = [], action) {
  switch (action.type) {
  case RECEIVE_USERS:
    return assign([], state, action.users);
  default:
    return state;
  }
}

export default users;
