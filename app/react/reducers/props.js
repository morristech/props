import merge from 'lodash/merge';
import assign from 'lodash/assign';

import {
  CHANGE_THANKS_TEXT,
  PROP_CREATED,
  PROP_CREATION_ERRORS,
  PROP_CREATION_REQUEST,
  RECEIVE_PROPS,
  REQUEST_PROPS,
  RECEIVE_USER_PROPS,
  REQUEST_USER_PROPS,
  RECEIVE_USER_GIVEN_PROPS,
  REQUEST_USER_GIVEN_PROPS,
  SELECT_USERS,
} from '../constants/action-types';

const initialState = {
  user_given_props: {},
  user_received_props: {},
  props: {},
  selected_users: [],
  prop_creation_errors: {},
  prop_creation_request: false,
  thanksText: '',
};

function props(state = initialState, action) {
  switch (action.type) {
  case CHANGE_THANKS_TEXT:
    return merge({}, state, {
      thanksText: action.body,
    });
  case RECEIVE_USER_GIVEN_PROPS:
    return merge({}, state, {
      user_given_props: action.props,
    });
  case RECEIVE_USER_PROPS:
    return merge({}, state, {
      user_received_props: action.props,
    });
  case RECEIVE_PROPS:
    return merge({}, state, {
      props: action.props,
    });
  case REQUEST_USER_GIVEN_PROPS:
    return assign({}, state, {
      user_given_props: {},
    });
  case REQUEST_USER_PROPS:
    return assign({}, state, {
      user_received_props: {},
    });
  case REQUEST_PROPS:
    return assign({}, state, {
      props: {},
    });
  case SELECT_USERS:
    return assign({}, state, {
      selected_users: action.id.split(','),
    });
  case PROP_CREATED:
    props = assign({}, state.props, {
      props: [action.prop, ...state.props.props],
    });
    return assign({}, state, {
      props: props,
      selected_users: [],
      prop_creation_errors: [],
      prop_creation_request: false,
      thanksText: '',
    });
  case PROP_CREATION_ERRORS:
    return assign({}, state, {
      prop_creation_errors: action.errors,
      prop_creation_request: false,
    });
  case PROP_CREATION_REQUEST:
    return assign({}, state, {
      prop_creation_request: true,
    });
  default:
    return state;
  }
}

export default props;
