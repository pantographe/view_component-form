# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Fixed
- Declare empty RichTextAreaComponent if ActionText is not installed, to fix Zeitwerk error (#120)

## [0.2.2] - 2022-03-23
### Changed
- Improve conditional ActionText support (#118)

## [0.2.1] - 2022-03-17
### Added
- Conditional ActionText support (#117)

### Fixed
- Fix broken gem initialization due to missing ViewComponent::Form constant (#114)
- Initialize empty WeekdaySelectComponent if Rails < 7 to fix Zeitwerk error (#115)

## [0.2.0] - 2022-03-02
### Added
- Test BuilderGenerator with generator\_spec (#64)
- Add HintComponent and ErrorMessageComponent (#98)
- Add `validation_context` option to `Form::Builder` (#101)
- Add `validators` helper to `FieldComponent` (#101)
- Add `optional?` and `required?` helpers to `FieldComponent` (#101)
- Add `label_text` helper (#103)
- Add `field_id` helper, backported from Rails 7.0 (#104)
- Add `weekday_select` helper (#105)
- Add README section about supported helpers (#106)
- Setup zeitwerk (#107)
- Add documentation for tests (#108)

## [0.1.3] - 2022-01-11
### Fixed
- Update dependencies for Rails 7.0.0 (#96)
- Bump to Rails 7 in Gemfile.lock (#99)

## [0.1.2] - 2021-12-07
### Added
- Add missing component specs (#75)
- Add missing builder specs for return values (#76)
- Add accurate test cases for all helpers from ActionView::Helpers::FormBuilder
  documentation (#85)

### Changed
- Cross-documented Rails form helpers (#84)
- Made tag_klass optional when inheriting from a component class (#87)
- Improve README: generator, html_class example (#88)
- Make rails version condition used the same way (#92)
- Add rails 7.0 and make rails head works (#94)
- Allow `Base` and `FieldComponent` to support forms without objects (#95)

### Fixed
- Fix `phone_field` helper (#74)
- Fix `datetime_local_field` helper (#76)
- Fix `time_zone_select` helper (#76)
- Resolve Rails 6.1 deprecation on ActiveModel::Errors#keys call (#91)

## [0.1.1] - 2021-09-27

### Changed
- Setup rspec-html-matchers and use it for complex components specs (#65)

### Fixed
- Fix errors methods in `BaseComponent` and `FieldComponent` (#71)

## [0.1.0] - 2021-09-16

### Added
- `FormBuilder`: add `.namespace` method to allow local lookup of components (#54)
- Add basic `ViewComponent::Form::Builder` that can be used in place of Rails' `ActionView::Helpers::FormBuilder` (#1)
- Add all standard FormBuilder helpers provided by Rails, implemented as ViewComponents (#4)
- Add a custom FormBuilder generator (#34)
- Add CHANGELOG (#50)
- Add CI (#2)

[Unreleased]: https://github.com/pantographe/view_component-form/compare/v0.2.2...HEAD
[0.2.2]: https://github.com/pantographe/view_component-form/compare/v0.2.1...v0.2.2
[0.2.1]: https://github.com/pantographe/view_component-form/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/pantographe/view_component-form/compare/v0.1.3...v0.2.0
[0.1.3]: https://github.com/pantographe/view_component-form/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/pantographe/view_component-form/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/pantographe/view_component-form/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/pantographe/view_component-form/releases/tag/v0.1.0
