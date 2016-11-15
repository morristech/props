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

import { RECEIVE_PROPS } from '../constants/props';


const props = (state = [], action = {}) => {
  switch (action.type) {
    case RECEIVE_PROPS:
      const props = action.payload.props.props;
      const normalizedProps = [];
      props.forEach((prop) => {
        const usersIds = prop.users.map(u => u.id);
        const propser = prop.propser.id;
        normalizedProps.push(
          Object.assign(prop, { propser, users: usersIds })
        );
      });

      return normalizedProps;
    default:
      return state;
  }
};

export default props;
