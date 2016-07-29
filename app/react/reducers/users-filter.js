import { SET_USERS_FILTER } from '../constants/action-types';

function usersFilter(state = '', action) {
  switch (action.type) {
    case SET_USERS_FILTER:
      return action.filter;
    default:
      return state;
  }
}

export default usersFilter;
