import expect from 'expect';
import reducer from './users';
import * as types from '../constants/action-types';

describe('users reducer', () => {
  it('returns the initial state', () => {
    expect(reducer(undefined, [])).toEqual([]);
  });

  it('handles RECEIVE_USERS', () => {
    const usersData = [{ userName: 'testUser' }, { userName: 'testUser2' }];

    expect(
      reducer(undefined, {
        type: types.RECEIVE_USERS,
        users: usersData,
      })
    ).toEqual(
      [
        { userName: 'testUser' },
        { userName: 'testUser2' },
      ]
    );
  });
});
