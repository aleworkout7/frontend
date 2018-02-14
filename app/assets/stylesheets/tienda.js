import { StyleSheet } from 'react-native';

export default StyleSheet.create({
  'input-search': {
    width: [{ unit: '%H', value: 1 }],
    borderRadius: '9px !important',
    border: [{ unit: 'px', value: 2 }, { unit: 'string', value: 'soliD' }, { unit: 'string', value: '#989898' }],
    fontSize: [{ unit: 'px', value: 19 }],
    paddingLeft: [{ unit: 'px', value: 11 }]
  },
  'margin-top-40': {
    marginTop: [{ unit: 'px', value: 40 }]
  },
  'input-btn-search': {
    backgroundColor: '#10100e',
    color: '#e2e2e2',
    border: [{ unit: 'px', value: 1 }, { unit: 'string', value: 'solid' }, { unit: 'string', value: 'black' }],
    paddingLeft: [{ unit: 'px', value: 10 }],
    paddingRight: [{ unit: 'px', value: 10 }],
    fontSize: [{ unit: 'px', value: 16 }],
    position: 'absolute',
    right: [{ unit: 'px', value: 15 }],
    bottom: [{ unit: 'px', value: 0 }],
    borderTopRightRadius: '6px !important',
    borderBottomRightRadius: '6px !important'
  },
  'text-found': {
    fontSize: [{ unit: 'px', value: 19 }],
    borderBottom: [{ unit: 'px', value: 2 }, { unit: 'string', value: 'solid' }, { unit: 'string', value: '#2d2d2d' }],
    width: [{ unit: 'px', value: 228 }],
    float: 'right',
    textAlign: 'center',
    display: 'block',
    marginBottom: [{ unit: 'px', value: 5 }],
    marginTop: [{ unit: 'px', value: 15 }],
    paddingBottom: [{ unit: 'px', value: 5 }]
  },
  'header-store': {
    backgroundColor: '#FDF25C',
    padding: [{ unit: 'px', value: 30 }, { unit: 'px', value: 30 }, { unit: 'px', value: 30 }, { unit: 'px', value: 30 }]
  },
  'margin-top-0': {
    marginTop: [{ unit: 'px', value: 0 }]
  },
  'logo-product': {
    marginBottom: [{ unit: 'px', value: 20 }]
  },
  'footer-cart': {
    backgroundColor: '#000',
    textAlign: 'center',
    padding: [{ unit: 'px', value: 60 }, { unit: 'px', value: 60 }, { unit: 'px', value: 60 }, { unit: 'px', value: 60 }],
    marginTop: [{ unit: 'px', value: 70 }],
    position: 'sticky',
    bottom: [{ unit: 'px', value: 0 }],
    width: [{ unit: '%H', value: 1 }]
  },
  'footer-cart > a > img': {
    width: [{ unit: 'px', value: 45 }],
    marginTop: [{ unit: 'px', value: -40 }]
  },
  inline: {
    display: '-webkit-box'
  },
  build: {
    width: [{ unit: 'px', value: 18 }]
  },
  'build-name': {
    marginTop: [{ unit: 'px', value: 2 }],
    marginLeft: [{ unit: 'px', value: 15 }],
    marginBottom: [{ unit: 'px', value: 25 }],
    fontSize: [{ unit: 'px', value: 28 }]
  },
  'price-product': {
    marginTop: [{ unit: 'px', value: 10 }],
    marginLeft: [{ unit: 'px', value: -4 }]
  },
  'price-product > span': {
    padding: [{ unit: 'px', value: 15 }, { unit: 'px', value: 15 }, { unit: 'px', value: 15 }, { unit: 'px', value: 15 }],
    border: [{ unit: 'px', value: 1 }, { unit: 'string', value: 'solid' }, { unit: 'string', value: '#bbbbbb' }],
    width: [{ unit: 'px', value: 70 }],
    fontSize: [{ unit: 'px', value: 20 }],
    fontWeight: 'bold',
    borderRadius: '4px'
  },
  'btn-plus': {
    textAlign: 'center',
    backgroundColor: '#B5E51D',
    display: 'block',
    width: [{ unit: 'px', value: 60 }],
    padding: [{ unit: 'px', value: 20 }, { unit: 'px', value: 20 }, { unit: 'px', value: 20 }, { unit: 'px', value: 20 }],
    borderRadius: '50%',
    position: 'absolute',
    right: [{ unit: 'px', value: 0 }],
    bottom: [{ unit: 'px', value: -9 }]
  },
  html: {
    height: [{ unit: '%V', value: 1 }],
    margin: [{ unit: 'px', value: 0 }, { unit: 'px', value: 0 }, { unit: 'px', value: 0 }, { unit: 'px', value: 0 }]
  },
  body: {
    height: [{ unit: '%V', value: 1 }],
    margin: [{ unit: 'px', value: 0 }, { unit: 'px', value: 0 }, { unit: 'px', value: 0 }, { unit: 'px', value: 0 }]
  },
  wrapper: {
    marginBottom: [{ unit: 'px', value: -50 }],
    minHeight: [{ unit: 'vh', value: NaN }]
  },
  footer: {
    height: [{ unit: 'px', value: 50 }]
  },
  push: {
    height: [{ unit: 'px', value: 50 }]
  }
});
