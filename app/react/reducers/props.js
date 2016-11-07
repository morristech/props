import merge from 'lodash/merge';
import assign from 'lodash/assign';

import {
  RECEIVE_USER_PROPS,
  REQUEST_USER_PROPS,
  RECEIVE_USER_GIVEN_PROPS,
  REQUEST_USER_GIVEN_PROPS,
} from '../constants/action-types';

// function props(state = {user_given_props: {}, user_received_props: {}}, action) {
//   switch (action.type) {
//   case RECEIVE_USER_GIVEN_PROPS:
//     return merge({}, state, {
//       user_given_props: action.props,
//     });
//   case RECEIVE_USER_PROPS:
//     return merge({}, state, {
//       user_received_props: action.props,
//     });
//   case REQUEST_USER_GIVEN_PROPS:
//     return assign({}, state, {
//       user_given_props: {},
//     });
//   case REQUEST_USER_PROPS:
//     return assign({}, state, {
//       user_received_props: {},
//     });
//   default:
//     return state;
//   }
// }


const props = (props = {}, action = {}) => {
  switch (action.type) {
    case 'RECEIVE_ALL_PROPS':
      let _props = {}
      action.payload.props.props.forEach((prop) => {
        _props = {
          ..._props,
          [prop.id]: prop,
        };
      });
      return {
        ...props,
        ..._props,
      };
    default:
      return props;
  }
};

export default props;
