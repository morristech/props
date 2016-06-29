import expect from 'expect';
import reducer from './user';
import * as types from '../constants/action-types';

describe('user reducer', () => {
  it('returns the initial state', () => {
    expect(reducer(undefined, {})).toEqual({ props_count: { given: 0, received: 0 } });
  });

  it('handles RECEIVE_USER', () => {
    const userData = { props_count: { given: 0, received: 0 }, userName: 'testUser' };

    expect(
      reducer(undefined, {
        type: types.RECEIVE_USER,
        user: userData,
      })
    ).toEqual(
      userData
    );
  });

  it('handles REQUEST_USER', () => {
    const previousState = { userName: 'testUser' };

    expect(
      reducer(previousState, {
        type: types.REQUEST_USER,
      })
    ).toEqual(
      { props_count: { given: 0, received: 0 }, userName: 'testUser' }
    );
  });
});
