import ParametricFetch from '../utilities/parametric-fetch';
import {
  REQUEST_USER_PROPS,
  RECEIVE_USER_PROPS,
  REQUEST_USER_GIVEN_PROPS,
  RECEIVE_USER_GIVEN_PROPS,
  RECEIVE_USER,
  REQUEST_USER,
  RECEIVE_USERS,
  REQUEST_USERS,
  SET_USERS_FILTER,
} from '../constants/action-types';

const api = new ParametricFetch({ baseURI: '/api/v1' });

function receiveUserProps(json) {
  return {
    type: RECEIVE_USER_PROPS,
    props: json,
  };
}

function requestUserProps() {
  return {
    type: REQUEST_USER_PROPS,
  };
}

function receiveUserGivenProps(json) {
  return {
    type: RECEIVE_USER_GIVEN_PROPS,
    props: json,
  };
}

function requestUserGivenProps() {
  return {
    type: REQUEST_USER_GIVEN_PROPS,
  };
}

function receiveUser(json) {
  return {
    type: RECEIVE_USER,
    user: json,
  };
}

function requestUser() {
  return {
    type: REQUEST_USER,
  };
}

function receiveUsers(json) {
  return {
    type: RECEIVE_USERS,
    users: json,
  };
}

function requestUsers() {
  return {
    type: REQUEST_USERS,
  };
}

export function setUsersFilter(filter) {
  return {
    type: SET_USERS_FILTER,
    filter,
  };
}

export function fetchUserProps(userId, page = 1, perPage = 25) {
  return dispatch => {
    dispatch(requestUserProps());
    return api.fetchMe(
      '/props',
      {
        user_id: userId,
        page: page,
        per_page: perPage,
      }
    ).then(json => dispatch(receiveUserProps(json)));
  };
}

export function fetchUserGivenProps(userId, page = 1, perPage = 25) {
  return dispatch => {
    dispatch(requestUserGivenProps());
    return api.fetchMe(
      '/props',
      {
        propser_id: userId,
        page: page,
        per_page: perPage,
      }
    ).then(json => dispatch(receiveUserGivenProps(json)));
  };
}

export function fetchUser(userId) {
  return dispatch => {
    dispatch(requestUser());
    return api.fetchMe(
      `/users/${userId}`
    ).then(json => dispatch(receiveUser(json)));
  };
}

export function fetchUsers() {
  return dispatch => {
    dispatch(requestUsers());
    return api.fetchMe(
      '/users'
    ).then(json => dispatch(receiveUsers(json)));
  };
}
