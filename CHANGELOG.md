## 0.5.1

- replace BaseResource.source to BaseResource.src

## 0.5.0

- Add `OpenBD::Resources::Onix::CollateralDetail`
- Add `OpenBD::Resources::Onix::Contributor`
- Add `OpenBD::Resources::Onix::DescriptiveDetail`
- Add `OpenBD::Resources::Onix::ProductSupply`
- Add `OpenBD::Resources::Onix::Publisher`
- Add `OpenBD::Resources::Onix::PublishingDetail`

## 0.4.5

- normalize_isbns() should be used only once
- add a spec of bulk_get with multiple isbns
- add OpenBD::Responses::Coverage#size

## 0.4.4

- OpenBD::Client.new: enable to define adapter and respnose parser
- add specs of OpenBD::Resources::OpenbdItem
- OpenBD::Resources::OpenbdItem.new: delay to generate objects
- add sample

## 0.4.3

- add OpenBD::Client specs for #get, #bulk_get, and #coverage
- bulk_get should use POST method

## 0.4.2

- add specs of OpenBD::Client#normalize_isbns
- make Client#normalize_isbns return String of Numbers (and `,` if needed)

## 0.4.1

- fix require

## 0.4.0

- Change Architecture. need to create `Client` instance.
- Add `OpenBD::Client`
- Add `OpenBD::Responses::BaseResoponse`
- Add `OpenBD::Responses::Coverage`
- Add `OpenBD::Responses::Get`
- Add `OpenBD::Responses::Schema`
- Add `OpenBD::Resources::BaseResource`
- Add `OpenBD::Resources::Hanmoto`
- Add `OpenBD::Resources::Onix`
- Add `OpenBD::Resources::OpenbdItem`
- Add `OpenBD::Resources::Summary`
