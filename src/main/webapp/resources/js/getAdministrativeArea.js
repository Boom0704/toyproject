function getAdministrativeArea(latitude, longitude) {
  const url = `https://nominatim.openstreetmap.org/reverse?format=json&lat=${latitude}&lon=${longitude}&zoom=18&addressdetails=1`;

  return fetch(url)
    .then(response => response.json())
    .then(data => {
      if (data && data.address) {
        const address = data.address;
        // 필요한 행정구역 정보를 추출하여 하나의 문자열로 반환
        const country = address.country || "";
        const state = address.state || "";
        const city = address.city || address.town || address.village || "";
        const district = address.county || address.suburb || "";
        const neighborhood = address.neighbourhood || "";

        // 행정구역을 스페이스로 구분하여 문자열로 반환
        const fullAddress = [country, state, city, district, neighborhood]
          .filter(part => part) // 빈 값은 제거
          .join(" "); // 스페이스로 연결

        return fullAddress;
      } else {
        console.error("행정구역 정보를 찾을 수 없습니다.");
        return "위치 정보를 찾을 수 없습니다.";
      }
    })
    .catch(error => {
      console.error("오류 발생: ", error);
      return "위치 정보를 가져오는데 실패했습니다.";
    });
}
