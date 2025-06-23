module.exports = {
  content: [
    './app/views/**/*.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js'
  ],
  safelist: [
    'bg-base-100',
    'bg-base-200',
    'bg-base-300',
    'text-base-100',
    'text-base-200',
  ],
  theme: {
    extend: {}
  },
  plugins: [require('daisyui')],
  daisyui: {
    themes: [
      {
        'custom-dark': {
          'primary': '#570df8',
          'secondary': '#f000b8',
          'accent': '#37cdbe',
          'neutral': '#3d4451',
          'base-100': '#01040a',
          'base-200': '#1a1f26',
          'base-300': '#262b32',
          'info': '#3abff8',
          'success': '#36d399',
          'warning': '#fbbd23',
          'error': '#f87272',
        },
      },
      'cupcake', 'synthwave', 'black', 'business', 'night', 'coffee', 'abyss', 'nord',
    ]
  }
}