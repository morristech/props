import fetch from 'isomorphic-fetch';
import series from 'async/series';

import {
  RECEIVE_USERS,
  SET_USERS_QUERY,
  RECEIVE_USER_PROFILE,
} from '../constants/users';

const fetchData = (path, callback) => (
  fetch(path, {
    credentials: 'same-origin',
  })
    .then(req => req.json())
    .then(json => callback(null, json))
);

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

export const receiveUserProfile = profile => ({
  type: RECEIVE_USER_PROFILE,
  payload: {
    profile,
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

export const fetchUserProfile = userId => dispatch => (
  series({
    profile: (callback) => {
      fetchData(`/api/v1/users/${userId}`, callback);
    },
    receivedProps: (callback) => {
      fetchData(`/api/v1/props?user_id=${userId}`, callback);
    },
    givenProps: (callback) => {
      fetchData(`/api/v1/props?propser_id=${userId}`, callback);
    },
  }, (err, { profile, receivedProps, givenProps }) => {
    dispatch(receiveUserProfile(profile));
    console.log(receivedProps);
    console.log(givenProps);
  })
);
