/* eslint-disable no-undef */
module.exports = {
  theme: {
    extend: {
      animation: {
        'gradient-x': 'gradient-x 10s ease infinite',
        'gradient-y': 'gradient-y 10s ease infinite',
        'gradient-xy': 'gradient-xy 10s ease infinite',
      },
      keyframes: {
        'gradient-y': {
          '0%, 100%': {
            'background-size': '400% 400%',
            'background-position': 'center top',
          },
          '50%': {
            'background-size': '200% 200%',
            'background-position': 'center center',
          },
        },
        'gradient-x': {
          '0%, 100%': {
            'background-size': '200% 200%',
            'background-position': 'left center',
          },
          '50%': {
            'background-size': '200% 200%',
            'background-position': 'right center',
          },
        },
        'gradient-xy': {
          '0%, 100%': {
            'background-size': '400% 400%',
            'background-position': 'left center',
          },
          '50%': {
            'background-size': '200% 200%',
            'background-position': 'right center',
          },
        },
      },
      colors: {
        'edd-blue': {
          '50': '#ecf3ff',
          '100': '#dde8ff',
          '200': '#c2d5ff',
          '300': '#9cb8ff',
          '400': '#758fff',
          '500': '#4d62ff',
          '600': '#363df5',
          '700': '#2a2ed8',
          '800': '#252aae',
          '900': '#262d89',
        },
      },
    },
  },
  variants: {},
  corePlugins: {
    aspectRatio: false,
  },
  plugins: [
    require('@tailwindcss/aspect-ratio'),
  ],
  content: [
    './app/**/*.html',
    './app/**/*.vue',
    './app/**/*.js',
    './app/**/*.erb',
  ],
};
