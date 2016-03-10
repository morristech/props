import expect from 'expect';
import reducer from './props';
import * as types from '../constants/action-types';

describe('props reducer', () => {
  it('returns the initial state', () => {
    expect(reducer(undefined, {})).toEqual({user_given_props: {}, user_received_props: {}});
  });

  it('handles RECEIVE_USER_PROPS', () => {
    const propsData = {props: [{}, {}], meta: {}};

    expect(
      reducer(undefined, {
        type: types.RECEIVE_USER_PROPS,
        props: propsData,
      })
    ).toEqual(
      {
        user_given_props: {},
        user_received_props: propsData,
      }
    );
  });

  it('handles RECEIVE_USER_GIVEN_PROPS', () => {
    const propsData = {props: [{}, {}], meta: {}};

    expect(
      reducer(undefined, {
        type: types.RECEIVE_USER_GIVEN_PROPS,
        props: propsData,
      })
    ).toEqual(
      {
        user_given_props: propsData,
        user_received_props: {},
      }
    );
  });
});
