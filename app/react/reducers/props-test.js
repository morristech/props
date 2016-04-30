import expect from 'expect';
import reducer from './props';
import * as types from '../constants/action-types';

describe('props reducer', () => {
  it('returns the initial state', () => {
    expect(reducer(undefined, {})).toEqual(
      { user_given_props: {}, user_received_props: {}, props: {} }
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
        user_given_props: {},
        user_received_props: propsData,
        props: {},
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
        user_given_props: propsData,
        user_received_props: {},
        props: {},
      }
    );
  });

  it('handles RECEIVE_PROPS', () => {
    const propsData = { props: [{}, {}], meta: {} };

    expect(
      reducer(undefined, {
        type: types.RECEIVE_PROPS,
        props: propsData,
      })
    ).toEqual(
      {
        user_given_props: {},
        user_received_props: {},
        props: propsData,
      }
    );
  });


  it('handles REQUEST_USER_GIVEN_PROPS', () => {
    const previousState = {
      user_given_props: { props: [], meta: [] },
      user_received_props: {},
      props: {},
    };

    expect(
      reducer(previousState, {
        type: types.REQUEST_USER_GIVEN_PROPS,
      })
    ).toEqual(
      {
        user_given_props: {},
        user_received_props: {},
        props: {},
      }
    );
  });

  it('handles REQUEST_USER_PROPS', () => {
    const previousState = {
      user_given_props: {},
      user_received_props: { props: [], meta: [] },
      props: {},
    };

    expect(
      reducer(previousState, {
        type: types.REQUEST_USER_PROPS,
      })
    ).toEqual(
      {
        user_given_props: {},
        user_received_props: {},
        props: {},
      }
    );
  });

  it('handles REQUEST_PROPS', () => {
    const previousState = {
      user_given_props: {},
      user_received_props: {},
      props: { props: [], meta: [] },
    };

    expect(
      reducer(previousState, {
        type: types.REQUEST_PROPS,
      })
    ).toEqual(
      {
        user_given_props: {},
        user_received_props: {},
        props: {},
      }
    );
  });
});
