import fetch from 'isomorphic-fetch';
import series from 'async/series';

import {
  RECEIVE_USERS,
  SET_USERS_QUERY,
  REQUEST_USER_PROFILE,
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

export const receiveUserProfile = (profile, receivedProps, givenProps) => ({
  type: RECEIVE_USER_PROFILE,
  payload: {
    profile,
    receivedProps,
    givenProps,
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

export const requestProfile = () => ({
  type: REQUEST_USER_PROFILE,
});

export const fetchUserProfile = userId => (dispatch) => {
  dispatch(requestProfile());
  return series({
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
    dispatch(receiveUserProfile(profile, receivedProps.props, givenProps.props));
  });
};
