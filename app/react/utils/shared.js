export const nopEvent = {
  preventDefault: () => {},
  stopPropagation: () => {},
};

export const createEventTarget = value => (
  {
    target: {
      value,
    },
  }
);
