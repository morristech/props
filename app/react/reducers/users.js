import assign from 'lodash/assign';

// import {
//   RECEIVE_USERS,
// } from '../constants/action-types';
//
// function users(state = [], action) {
//   switch (action.type) {
//   case RECEIVE_USERS:
//     return assign([], state, action.users);
//   default:
//     return state;
//   }
// }

import { RECEIVE_USERS } from '../constants/users';

const users = (state = {}, action = {}) => {
  switch (action.type) {
    case RECEIVE_USERS:
      const normalizedUsers = {};
      action.payload.users.forEach((user) => {
        normalizedUsers[user.id] = user;
      });
      return assign({}, state, normalizedUsers);
    default:
      return state;
  }
};

export default users;
