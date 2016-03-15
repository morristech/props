import fetch from 'isomorphic-fetch';

import {
  RECEIVE_USER_PROPS,
  RECEIVE_USER_GIVEN_PROPS,
  RECEIVE_USER,
} from '../constants/action-types';

function receiveUserProps(json) {
  return {
    type: RECEIVE_USER_PROPS,
    props: json,
  };
}

function receiveUserGivenProps(json) {
  return {
    type: RECEIVE_USER_GIVEN_PROPS,
    props: json,
  };
}

function receiveUser(json) {
  return {
    type: RECEIVE_USER,
    user: json,
  };
}

export function fetchUserProps(userId) {
  return dispatch => {
    return fetch(`/api/props?user_id=${userId}`, {
      credentials: 'same-origin',
    })
    .then(req => req.json())
    .then(json => dispatch(receiveUserProps(json)));
  };
}

export function fetchUserGivenProps(userId) {
  return dispatch => {
    return fetch(`/api/props?propser_id=${userId}`, {
      credentials: 'same-origin',
    })
    .then(req => req.json())
    .then(json => dispatch(receiveUserGivenProps(json)));
  };
}

export function fetchUser(userId) {
  return dispatch => {
    return fetch(`/api/users/${userId}`, {
      credentials: 'same-origin',
    })
    .then(req => req.json())
    .then(json => dispatch(receiveUser(json)));
  };
}
