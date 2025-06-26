module.exports = {
  content: [
    './app/views/**/*.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js'
  ],
  safelist: [
    'line-clamp-1',
    'line-clamp-2',
    'line-clamp-3',
    'text-gray-400',
    'text-gray-500',
    'bg-base-100',
    'bg-base-200',
    'bg-base-300',
    'text-base-100',
    'text-base-200',
  ],
  theme: {
    extend: {}
  },
  plugins: [
    require('daisyui'),
    require('@tailwindcss/line-clamp'),
  ],
  daisyui: {
    themes: [
      {
        'custom-dark': {
          'primary': '#570df8',
          'secondary': '#f000b8',
          'accent': '#05317d',
          'neutral': '#3d4451',
          'base-100': '#01040a',
          'base-200': '#1a1f26',
          'base-300': '#262b32',
          'info': '#3abff8',
          'success': '#36d399',
          'warning': '#fbbd23',
          'error': '#f87272',
        },
      }
    ]
  }
}