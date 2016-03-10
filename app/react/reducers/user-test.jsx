import expect from 'expect';
import reducer from './user';
import * as types from '../constants/action-types';

describe('props reducer', () => {
  it('returns the initial state', () => {
    expect(reducer(undefined, {})).toEqual({});
  });

  it('handles RECEIVE_USER', () => {
    const userData = {userName: 'testUser'};

    expect(
      reducer(undefined, {
        type: types.RECEIVE_USER,
        user: userData,
      })
    ).toEqual(
      userData
    );
  });
});
