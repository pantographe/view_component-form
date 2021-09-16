# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- `FormBuilder`: add `.namespace` method to allow local lookup of components (#54)
- Add basic `ViewComponent::Form::Builder` that can be used in place of Rails' `ActionView::Helpers::FormBuilder` (#1)
- Add all standard FormBuilder helpers provided by Rails, implemented as ViewComponents (#4)
- Add a custom FormBuilder generator (#34)
- Add CHANGELOG (#50)
- Add CI (#2)
