import assign from 'lodash/assign';

import {
  RECEIVE_USER,
  REQUEST_USER,
} from '../constants/action-types';

const initialState = { props_count: { given: 0, received: 0 } };

function user(state = initialState, action) {
  switch (action.type) {
    case RECEIVE_USER:
      return assign({}, state, action.user);
    case REQUEST_USER:
      return assign({}, state, initialState);
    default:
      return state;
  }
}

export default user;
