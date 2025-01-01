enum OptionValueBaseListRequest {
  // Custom khong co type nay call api rieng
  loaiHD('LoaiHD'),
  lastPosStr('lastPosStr'),
  lastOrgStr('lastOrgStr'),
  truongHoc('TruongHoc'),
  city('ThanhPho'),
  nation('QuocGia'),
  takeLeave('LyDoXinNghiPhep'),
  jobTitle('JobTitle'),
  jobPosition('jobPosition'),
  //

  quanHeGiaDinh('QuanHeGiaDinh'),
  loaiQuyetDinh('LoaiQuyetDinh'),
  lyDoThoiViec('LyDoThoiViec'),
  noiCapCMND('NoiCapCMND'),
  danToc('DanToc'),
  tinhTrangHonNhan('TinhTrangHonNhan'),
  tonGiao('TonGiao'),
  trinhDoDaoTao('TrinhDoDaoTao'),
  chuyenNganh('ChuyenNganh'),
  khuVuc('KhuVuc'),
  bacLD('BacLD'),
  trangThaiCongViec('TrangThaiCongViec'),
  hinhThucDaoTao('HinhThucDaoTao'),
  xepLoaiChungChi('XepLoaiChungChi'),
  loaiTruongDaiHoc('LoaiTruongDaiHoc'),
  loaiVanBang('LoaiVanBang'),
  loaiKienNghi('LoaiKienNghi');

  const OptionValueBaseListRequest(this.value);
  final String value;
}
