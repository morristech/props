import expect from 'expect';
import reducer from './users-filter';
import * as types from '../constants/action-types';

describe('usersFilter reducer', () => {
  it('returns the initial state', () => {
    expect(reducer(undefined, '')).toEqual('');
  });

  it('handles SET_USERS_FILTER', () => {
    const filter = 'something';

    expect(
      reducer(undefined, {
        type: types.SET_USERS_FILTER,
        filter,
      })
    ).toEqual('something');
  });
});
