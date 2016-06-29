import expect from 'expect';
import reducer from './props';
import * as types from '../constants/action-types';

describe('props reducer', () => {
  it('returns the initial state', () => {
    expect(reducer(undefined, {}))
    .toEqual(
      {
        given_props_request: true,
        received_props_request: true,
        user_given_props: {},
        user_received_props: {},
      }
    );
  });

  it('handles RECEIVE_USER_PROPS', () => {
    const propsData = { props: [{}, {}], meta: {} };

    expect(
      reducer(undefined, {
        type: types.RECEIVE_USER_PROPS,
        props: propsData,
      })
    ).toEqual(
      {
        given_props_request: true,
        received_props_request: false,
        user_given_props: {},
        user_received_props: propsData,
      }
    );
  });

  it('handles RECEIVE_USER_GIVEN_PROPS', () => {
    const propsData = { props: [{}, {}], meta: {} };

    expect(
      reducer(undefined, {
        type: types.RECEIVE_USER_GIVEN_PROPS,
        props: propsData,
      })
    ).toEqual(
      {
        given_props_request: false,
        received_props_request: true,
        user_given_props: propsData,
        user_received_props: {},
      }
    );
  });

  it('handles REQUEST_USER_GIVEN_PROPS', () => {
    const previousState = {
      user_given_props: { props: [], meta: [] },
      user_received_props: {},
    };

    expect(
      reducer(previousState, {
        type: types.REQUEST_USER_GIVEN_PROPS,
      })
    ).toEqual(
      {
        given_props_request: true,
        user_given_props: {},
        user_received_props: {},
      }
    );
  });

  it('handles REQUEST_USER_PROPS', () => {
    const previousState = {
      user_given_props: {},
      user_received_props: { props: [], meta: [] },
    };

    expect(
      reducer(previousState, {
        type: types.REQUEST_USER_PROPS,
      })
    ).toEqual(
      {
        received_props_request: true,
        user_given_props: {},
        user_received_props: {},
      }
    );
  });
});
