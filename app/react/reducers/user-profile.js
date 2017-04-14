import assign from 'lodash/assign';
import { RECEIVE_USER_PROFILE } from '../constants/users';

const userProfile = (state = {}, action = {}) => {
  switch (action.type) {
    case RECEIVE_USER_PROFILE:
      return assign({}, state,
        action.payload.profile,
        { receivedProps: action.payload.receivedProps.map(prop => ({
          ...prop,
          propser: prop.propser.id,
          users: prop.users.map(u => u.id),
        })),
        },
        { givenProps: action.payload.givenProps.map(prop => ({
          ...prop,
          propser: prop.propser.id,
          users: prop.users.map(u => u.id),
        })),
        },
      );
    default:
      return state;
  }
};

export default userProfile;
