import expect from 'expect';
import reducer from './props';
import * as types from '../constants/action-types';

describe('props reducer', () => {
  it('returns the initial state', () => {
    expect(reducer(undefined, {})).toEqual(
      {
        prop_creation_errors: {},
        prop_creation_request: false,
        props: { props: [], meta: {} },
        selected_users: [],
        thanksText: '',
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
        prop_creation_errors: {},
        prop_creation_request: false,
        props: { props: [], meta: {} },
        selected_users: [],
        thanksText: '',
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
        prop_creation_errors: {},
        prop_creation_request: false,
        props: { props: [], meta: {} },
        selected_users: [],
        thanksText: '',
        user_given_props: propsData,
        user_received_props: {},
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
        prop_creation_errors: {},
        prop_creation_request: false,
        props: propsData,
        selected_users: [],
        thanksText: '',
        user_given_props: {},
        user_received_props: {},
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

  it('handles CHANGE_THANKS_TEXT', () => {
    const thanksText = 'thanks';

    expect(
      reducer(undefined, {
        type: types.CHANGE_THANKS_TEXT,
        body: thanksText,
      })
    ).toEqual(
      {
        prop_creation_errors: {},
        prop_creation_request: false,
        props: { props: [], meta: {} },
        selected_users: [],
        thanksText,
        user_given_props: {},
        user_received_props: {},
      }
    );
  });

  it('handles PROP_CREATION_REQUEST', () => {
    expect(
      reducer(undefined, {
        type: types.PROP_CREATION_REQUEST,
      })
    ).toEqual(
      {
        prop_creation_errors: {},
        prop_creation_request: true,
        props: { props: [], meta: {} },
        selected_users: [],
        thanksText: '',
        user_given_props: {},
        user_received_props: {},
      }
    );
  });

  it('handles PROP_CREATION_ERRORS', () => {
    const errors = { body: 'cannot be null' };
    expect(
      reducer(undefined, {
        type: types.PROP_CREATION_ERRORS,
        errors,
      })
    ).toEqual(
      {
        prop_creation_errors: errors,
        prop_creation_request: false,
        props: { props: [], meta: {} },
        selected_users: [],
        thanksText: '',
        user_given_props: {},
        user_received_props: {},
      }
    );
  });

  it('handles PROP_CREATED', () => {
    const prop = {
      body: 'prop body',
      propser: {
        id: 1,
        avatarUrl: 'https://test1.img',
        name: 'user name',
      },
      users: [{
        id: 1,
        avatarUrl: 'https://test1.img',
        name: 'user name',
      }],
      createdAt: Date.parse('2015/10/10 12:00:00'),
      upvotesCount: 10,
      isUpvotePosssible: true,
    };

    expect(
      reducer(undefined, {
        type: types.PROP_CREATED,
        prop,
      })
    ).toEqual(
      {
        prop_creation_errors: {},
        prop_creation_request: false,
        props: { meta: {}, props: [prop] },
        selected_users: [],
        thanksText: '',
        user_given_props: {},
        user_received_props: {},
      }
    );
  });
});
