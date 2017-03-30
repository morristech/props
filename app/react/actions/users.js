import fetch from 'isomorphic-fetch';
import { RECEIVE_USERS, SET_USERS_QUERY } from '../constants/users';

export const receiveUsers = users => ({
  type: RECEIVE_USERS,
  payload: {
    users,
  },
});

export const setUsersQuery = query => ({
  type: SET_USERS_QUERY,
  payload: {
    query,
  },
});

export const fetchUsers = () => dispatch => (
  fetch('/api/v1/users', {
    credentials: 'same-origin',
  })
  .then(req => req.json())
  .then((json) => {
    dispatch(receiveUsers(json));
  })
);
