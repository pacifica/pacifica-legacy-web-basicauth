Name: pacifica-web-basicauth
Version: 1.0.0
Release: 1
Summary: Pacifica Web Basic Auth
Group: System Environment/Base
License: LGPL 2.1
Source: %{name}-%{version}.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}
BuildArch: noarch

%description
Pacifica Web Basic Auth

%prep
%setup -q -n %{name}-%{version}

%build

%install
dir=$RPM_BUILD_ROOT/%{_sysconfdir}/myemsl
mkdir -p $dir
install conf/webauth-ssl.conf $dir/webauth-ssl.conf

%files
%defattr(0644,root,root)
%config %{_sysconfdir}/myemsl/webauth-ssl.conf

