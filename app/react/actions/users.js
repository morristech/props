import fetch from 'isomorphic-fetch';
import { RECEIVE_USERS } from '../constants/users';

export const receiveUsers = users => ({
  type: RECEIVE_USERS,
  payload: {
    users,
  },
});

export const fetchUsers = () => dispatch => {
  return fetch('/api/v1/users', {
    credentials: 'same-origin',
  })
  .then(req => req.json())
  .then((json) => {
    console.log(json)
    dispatch(receiveUsers(json));
  });
};
